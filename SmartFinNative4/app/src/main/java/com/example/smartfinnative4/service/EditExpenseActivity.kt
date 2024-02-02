package com.example.smartfinnative4.service

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Window
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.example.smartfinnative4.R
import com.example.smartfinnative4.databinding.UpdateExpenseBinding
import com.example.smartfinnative4.model.Expense
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException

class EditExpenseActivity : AppCompatActivity() {

    lateinit var id: Number
    private lateinit var initialExpense: Expense

    private lateinit var cancelButton: Button
    private lateinit var saveButton: Button

    lateinit var binding: UpdateExpenseBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.i("in on create", "in edit expense")

        super.onCreate(savedInstanceState)

        binding = UpdateExpenseBinding.inflate(layoutInflater)
        setContentView(binding.root)

        supportActionBar?.hide()

        val window: Window = this@EditExpenseActivity.window
        window.statusBarColor = ContextCompat.getColor(this@EditExpenseActivity, R.color.black)

        val bundle = intent.getBundleExtra("expenseBundle")
        if (bundle != null) {
            Log.i("in edit", "bundle not null")
            val expense = bundle.getSerializable("expense") as? Expense
            Log.i("expense", expense.toString())
            if (expense != null) {
                initialExpense = expense;
                Log.i("id of selected expense", expense.id.toString())
                id = expense.id
            }
        }

        initializaInputs()

        saveButton = binding.saveButtonUpdate
        cancelButton = binding.cancelButtonUpdate

        saveButton.setOnClickListener() {
            editExpense()
        }

        cancelButton.setOnClickListener()
        {
            goBack()
        }
    }


    private fun editExpense() {
        if (checks()) {
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")

            initialExpense.title = binding.titleInputUpdate.text.toString()
            initialExpense.description = binding.descriptionInputUpdate.text.toString()
            initialExpense.amount = binding.amountInputUpdate.text.toString().toInt()
            initialExpense.category = binding.categoryInputUpdate.text.toString()
            initialExpense.date =
                LocalDate.parse(binding.dateInputUpdate.text.toString(), formatter)
            initialExpense.payment_method = binding.paymentMethInputUpdate.text.toString()

            val bunle = Bundle()
            bunle.putSerializable("expense", initialExpense)
            intent.putExtra("expenseBundle", bunle)
            intent.putExtra("id", id)
            setResult(RESULT_OK, intent)
            finish()

        } else {
            Toast.makeText(
                this, "All fields must be completed and date must have the format yyyy-MM-dd",
                Toast.LENGTH_LONG
            ).show()
        }
    }

    private fun goBack() {
        intent = Intent()
        finish()
    }


    private fun checks(): Boolean {
        if (binding.titleInputUpdate.text.isEmpty() or binding.descriptionInputUpdate.text.isEmpty() or binding.amountInputUpdate.text.isEmpty() or binding.categoryInputUpdate.text.isEmpty()
            or binding.dateInputUpdate.text.isEmpty() or binding.paymentMethInputUpdate.text.isEmpty()
        )
            return false

        val dateVf = binding.dateInputUpdate.text.toString()
        if (!isValidDate(dateVf))
            return false

        return true
    }

    fun isValidDate(str: String): Boolean {
        try {
            val dateTime: LocalDate = LocalDate.parse(str)
            Log.i("in isValidDate", dateTime.toString())
        } catch (ex: DateTimeParseException) {
            return false
        }
        return true
    }


    private fun initializaInputs() {
        binding.idInputUpdate.setText(id.toString())
        binding.idInputUpdate.isEnabled = false
        binding.titleInputUpdate.setText(initialExpense.title)
        binding.descriptionInputUpdate.setText(initialExpense.description)
        binding.amountInputUpdate.setText(initialExpense.amount.toString())
        binding.categoryInputUpdate.setText(initialExpense.category)
        binding.dateInputUpdate.setText(initialExpense.date.toString())
        binding.paymentMethInputUpdate.setText(initialExpense.payment_method)
    }
}