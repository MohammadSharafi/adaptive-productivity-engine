package com.focuscraft.domain.repository;

import com.focuscraft.domain.model.ProductivitySession;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface ProductivitySessionRepository {
    List<ProductivitySession> findAll();
    List<ProductivitySession> findByDateRange(LocalDateTime start, LocalDateTime end);
    Optional<ProductivitySession> findById(Long id);
    Optional<ProductivitySession> findActiveSession();
    ProductivitySession save(ProductivitySession session);
    void deleteById(Long id);
}

