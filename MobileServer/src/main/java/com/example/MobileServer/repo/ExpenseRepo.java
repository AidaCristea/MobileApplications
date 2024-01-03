package com.example.MobileServer.repo;

import com.example.MobileServer.domain.Expense;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExpenseRepo extends JpaRepository<Expense, Integer> {
}
