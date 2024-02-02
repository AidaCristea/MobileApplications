package com.example.smartfinnative4.service

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.view.Window
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.example.smartfinnative4.databinding.AddExpenseBinding
import com.example.smartfinnative4.R
import com.example.smartfinnative4.model.Expense
import java.io.Serializable
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException

class AddExpenseActivity: AppCompatActivity() {


    lateinit var cancelButton: Button
    lateinit var saveButton: Button
    lateinit var id: String
    lateinit var binding: AddExpenseBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.i("i", " in add expense activity")

        super.onCreate(savedInstanceState)

        binding = AddExpenseBinding.inflate(layoutInflater)
        //setContentView(R.layout.expenses_list)
        setContentView(binding.root)

        supportActionBar?.hide()

        val window: Window = this@AddExpenseActivity.window
        window.statusBarColor=ContextCompat.getColor(this@AddExpenseActivity, R.color.black)

        binding.idInputCreate.setText(Expense.currentId.toString())

        saveButton = findViewById(R.id.saveButtonCreate)
        cancelButton=findViewById(R.id.cancelButtonCreate)

        saveButton.setOnClickListener(){
            addExpense();
        }

        cancelButton.setOnClickListener() {
            goBack();
        }

    }

    private fun addExpense(){
        if(checks())
        {
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")

            val expense = Expense(
                binding.titleInputCreate.text.toString(),
                binding.descriptionInputCreate.text.toString(),
                binding.amountInputCreate.text.toString().toInt(),
                binding.categoryInputCreate.text.toString(),
                LocalDate.parse(binding.dateInputCreate.text.toString(), formatter),
                binding.paymentMethInputCreate.text.toString()
            )
            Log.i("in addExpense", expense.toString())

            val bundle = Bundle()
            bundle.putSerializable("expense", expense)
            intent.putExtra("expenseBundle", bundle)
            setResult(RESULT_OK, intent)
            finish()
        }
        else
        {
            Toast.makeText(
                this, "All fields must be completed and date must have the format yyyy-MM-dd",
                Toast.LENGTH_LONG
            ).show()
        }

    }

    private fun checks(): Boolean{
        if(binding.titleInputCreate.text.isEmpty() or binding.descriptionInputCreate.text.isEmpty() or binding.amountInputCreate.text.isEmpty() or binding.categoryInputCreate.text.isEmpty()
            or binding.dateInputCreate.text.isEmpty() or binding.paymentMethInputCreate.text.isEmpty())
            return false

        val dateVf = binding.dateInputCreate.text.toString()
        if(!isValidDate(dateVf))
            return false

        return true
    }

    fun isValidDate(str: String): Boolean{
        try{
            val dateTime: LocalDate = LocalDate.parse(str)
            Log.i("in isValidDate", dateTime.toString())
        } catch(ex:DateTimeParseException)
        {
            return false
        }
        return true
    }

    private fun goBack(){
        intent= Intent()
        finish()
    }

}