package com.example.smartfinnative4.allExpenses

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Window
import android.widget.ImageView
import android.widget.Toast

import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
//import androidx.databinding.DataBindingUtil
import com.example.smartfinnative4.R
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.smartfinnative4.adapter.CustomAdapter
import com.example.smartfinnative4.databinding.ExpensesListBinding
import com.example.smartfinnative4.model.Expense

import com.example.smartfinnative4.service.AddExpenseActivity
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import kotlin.math.exp


class ExpensesListActivity : AppCompatActivity(){

    private val expenses = mutableListOf<Expense>()
    lateinit var addButton: ImageView
    private lateinit var binding: ExpensesListBinding


    override fun onCreate(savedInstanceState: Bundle?)
    {
        var str = "LIST ACTIVITY"
        Log.i(str, "Am intrat in list")
        super.onCreate(savedInstanceState)

        binding = ExpensesListBinding.inflate(layoutInflater)
        //setContentView(R.layout.expenses_list)
        setContentView(binding.root)



        //binding = DataBindingUtil.setContentView(this, R.layout.expense_item)
        supportActionBar?.hide()

        val window: Window = this@ExpensesListActivity.window
        window.statusBarColor=ContextCompat.getColor(this@ExpensesListActivity, R.color.black)

        initExpenses()


        binding.recylerView.layoutManager=LinearLayoutManager(this)
        val adapter = CustomAdapter(this, expenses)
        binding.recylerView.adapter=adapter

        addButton = findViewById(R.id.addExpenseButton)

        addButton.setOnClickListener{
            Log.i("in expenseListAct", " in addButton Click")
            val intent = Intent(applicationContext, AddExpenseActivity::class.java)
            startActivityForResult(intent, 3)
        }

    }

    @SuppressLint("NotifyDataSetChanged")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        //binding = ExpensesListBinding.inflate(layoutInflater)

        if(requestCode==3)
        {
            Log.i("in onActivityResult", " before ResultCode")
            if(resultCode==Activity.RESULT_OK)
            {
                Log.i("the new expense", data.toString())
                if(data!=null)
                {
                    val bundle = data.getBundleExtra("expenseBundle")
                    val expense = bundle?.getSerializable("expense") as? Expense
                    Log.i("exp to be added", expense.toString())
                    if(expense!=null)
                    {
                        addExpenseToList(expense)
                        Log.i("after called addExpenseToList", " afetr")
                        binding.recylerView.adapter?.notifyItemInserted(expenses.size-1)
                        Log.i("after adapter call", "called adapter")
                        Toast.makeText(this, "Added!", Toast.LENGTH_SHORT).show()

                    }
                }
            }
        }
        else if(requestCode==5)
        {
            if(resultCode==Activity.RESULT_OK)
            {
                if(data!=null)
                {
                    val bundle = data.getBundleExtra("expenseBundle")
                    val expense = bundle?.getSerializable("expense") as? Expense
                    val id = data.getIntExtra("id", -1)
                    if(expense != null && id != -1)
                        updateExpense(expense, id)

                }
            }
        }

    }

    private fun updateExpense(expense: Expense, id: Number)
    {
        for(i in 0 until expenses.size)
        {
            if(expenses[i].id==id)
            {
                expenses[i]=expense
                Toast.makeText(this, "Updated", Toast.LENGTH_SHORT).show()
                binding.recylerView.adapter?.notifyItemChanged(i)
            }
        }
    }

    private fun addExpenseToList(expense: Expense)
    {
        expenses.add(expense)
    }


    private fun initExpenses()
    {
        Log.i("str","in init expenses")
        val formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")

        val exp1=Expense(
            "Grocery Shopping",
            "Weekly groceries including fruits, vegetables, and household essentials.",
            150,
            "Food & Household",
            LocalDate.parse("03-04-2023", formatter),
            "Card"

        )

        val exp2=Expense(
            "Internet Bill",
            "Monthly payment for internet.",
            60,
            "Utilities",
            LocalDate.parse("20-09-2023", formatter),
            "Automatic Bank Transfer"

        )

        val exp3 = Expense(
            "Gas Bill",
            "Monthly payment for gas.",
            40,
            "Utilities",
            LocalDate.parse("15-09-2023", formatter),
            "Card"
        )

        val exp4 = Expense(
            "Dinner Out",
            "Dining at a local restaurant.",
            35,
            "Food & Dining",
            LocalDate.parse("25-09-2023", formatter),
            "Credit Card"
        )

        val exp5 = Expense(
            "Movie Night",
            "Tickets for a movie night.",
            25,
            "Entertainment",
            LocalDate.parse("28-09-2023", formatter),
            "Cash"
        )

        expenses.add(exp1)
        expenses.add(exp2)
        expenses.add(exp3)
        expenses.add(exp4)
        expenses.add(exp5)


        Log.i("in init expenses", "after added exp1")
        Log.i("dd", expenses.toString())

    }
}