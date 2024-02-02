package com.example.smartfinnative4.model

import android.util.Log
import java.io.Serializable
import java.time.LocalDate

data class Expense(var title: String, var description: String, var amount: Int, var category: String,
                   var date: LocalDate, var payment_method: String, var id: Int): Serializable
{
    companion object {
        var currentId = 0
    }

    constructor(
        title: String, description: String, amount: Int, category: String, date: LocalDate, payment_method: String
    ) : this(
        title, description, amount, category, date, payment_method, currentId++
    ) {
        Log.i("Model Expense class: ", "CurrentId is $currentId")
    }


}
