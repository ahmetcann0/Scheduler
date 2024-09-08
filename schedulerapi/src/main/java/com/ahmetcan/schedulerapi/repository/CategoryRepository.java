package com.ahmetcan.schedulerapi.repository;


import com.ahmetcan.schedulerapi.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Set;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    Set<Category> findByUserId(Long userId);
}

