package com.ahmetcan.schedulerapi.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {

    public void sendNotification(Long userId, String title, String body) {
        // Kullanıcının cihaz token'ını almak için uygun bir yöntem kullan
        String userToken = getUserToken(userId);

        // Bildirim oluşturma
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(body)
                .build();

        // Mesaj oluşturma
        Message message = Message.builder()
                .setToken(userToken)
                .setNotification(notification)
                .build();

        try {
            String response = FirebaseMessaging.getInstance().send(message);
            System.out.println("Başarıyla gönderildi: " + response);
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }
    }

    private String getUserToken(Long userId) {
        // Kullanıcının cihaz token'ını veritabanından almanız gerekebilir.
        // Bu, örneğin kullanıcı tablonuzda saklanan bir alan olabilir.
        return "kullanici-token"; // Bu kısmı gerçek token ile değiştirin.
    }
}
