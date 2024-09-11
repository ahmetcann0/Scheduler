package com.ahmetcan.schedulerapi.service;

import com.ahmetcan.schedulerapi.model.ToDoListItem;
import com.ahmetcan.schedulerapi.repository.ToDoListItemRepository;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Component
public class NotificationScheduler {

    @Autowired
    private ToDoListItemRepository todoListItemRepository; // Veritabanı erişimi için

    @Autowired
    private NotificationService notificationService; // Bildirim gönderimi için

    @Scheduled(fixedRate = 60000) // 1 dakikada bir çalışır
    public void checkForNotifications() {
        LocalDateTime now = LocalDateTime.now();
        List<ToDoListItem> upcomingItems = todoListItemRepository.findByDueDateBetween(now, now.plusMinutes(1));
        for (ToDoListItem item : upcomingItems) {
            String title = "Görev Zamanı: " + item.getTitle();
            String body = "Görev tarihiniz geldi: " + item.getDueDate();
            notificationService.sendNotification(item.getUserId(), title, body);
        }
    }
}

