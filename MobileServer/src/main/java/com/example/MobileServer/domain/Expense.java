package com.example.MobileServer.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Expense")
public class Expense {

    @Id
    @Column(name = "_id")
    private Integer id;
    private String title;
    private String description;
    private Integer amount;
    private String category;
    private Date date;
    private String payment_method;

}
