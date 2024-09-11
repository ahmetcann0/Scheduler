package com.ahmetcan.schedulerapi.repository;

import com.ahmetcan.schedulerapi.model.ToDoListItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ToDoListItemRepository extends JpaRepository<ToDoListItem, Long> {

    List<ToDoListItem> findByUserId(Long userId);
    List<ToDoListItem> findByDueDateBetween(LocalDateTime startDate, LocalDateTime endDate);

}
