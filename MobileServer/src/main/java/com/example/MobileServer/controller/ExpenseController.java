package com.example.MobileServer.controller;


import com.example.MobileServer.domain.Expense;
import com.example.MobileServer.service.ExpenseService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/expense")
public class ExpenseController {

    private final ExpenseService expenseService;

    @PostMapping
    public ResponseEntity<Expense> createExpense(@RequestBody Expense expense) {
        Expense createdExpense = expenseService.createExpense(expense);
        return new ResponseEntity<>(createdExpense, HttpStatus.CREATED);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Expense> getExpense(@PathVariable Integer id) {
        Expense expense = expenseService.getExpense(id);
        return new ResponseEntity<>(expense, HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<List<Expense>> getAllExpenses() {
        List<Expense> expenses = expenseService.allExpenses();
        return new ResponseEntity<>(expenses, HttpStatus.OK);
    }

    @PutMapping
    public ResponseEntity<Expense> updateExpense(@RequestBody Expense updatedExpense) {
        try {
            Expense updatedExp = expenseService.updateExpense(updatedExpense);
            return new ResponseEntity<>(updatedExp, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExpense(@PathVariable Integer id) throws Exception {
        expenseService.deleteExpense(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
