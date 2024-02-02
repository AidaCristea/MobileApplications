package com.example.MobileServer.service;

import com.example.MobileServer.domain.Expense;
import com.example.MobileServer.repo.ExpenseRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ExpenseService {

    private final ExpenseRepo expenseRepo;

    //create expense
    public Expense createExpense(Expense expense) {
        Expense savedExp = expenseRepo.save(expense);
        System.out.println("The expense: " + expense.toString() + " was successfully saved!");
        return savedExp;
    }

    //get expense
    public Expense getExpense(Integer id) {
        Expense foundExp = expenseRepo.findById(id).orElseThrow();
        System.out.println("The expense with the given id is " + foundExp.toString());
        return foundExp;
    }

    //get all
    public List<Expense> allExpenses() {
        System.out.println("Returning all expenses");
        return expenseRepo.findAll();
    }

    //update expense
    public Expense updateExpense(Expense updatedExp) throws Exception {
        Optional<Expense> searchExp = expenseRepo.findById(updatedExp.getId());
        if (searchExp.isPresent()) {
            Expense foundExp = searchExp.get();
            foundExp.setTitle(updatedExp.getTitle());
            foundExp.setDescription(updatedExp.getDescription());
            foundExp.setAmount(updatedExp.getAmount());
            foundExp.setCategory(updatedExp.getCategory());
            foundExp.setDate(updatedExp.getDate());
            foundExp.setPayment_method(updatedExp.getPayment_method());
            System.out.println("Updated expense: " + foundExp.toString());
            return expenseRepo.save(foundExp);
        } else {
            throw new Exception("No expense found!");
        }

    }


    //delete expense
    public void deleteExpense(Integer id) throws Exception {
        if (!expenseRepo.existsById(id)) {
            throw new Exception("No expense with the given id was found");
        }
        System.out.println("Delete expense with the given id");
        expenseRepo.deleteById(id);
    }


}
