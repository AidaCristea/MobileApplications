package com.example.smartfinnative4.adapter

import android.annotation.SuppressLint
import android.app.Dialog
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.smartfinnative4.R
import com.example.smartfinnative4.allExpenses.ExpensesListActivity
import com.example.smartfinnative4.databinding.ExpenseItemBinding
//import com.example.smartfinnative4.model.Expense
import com.example.smartfinnative4.model.Expense

import com.example.smartfinnative4.service.EditExpenseActivity
import java.io.Serializable

//import kotlinx.android.synthetic.main.expense_item.view.*


class CustomAdapter(private val context: ExpensesListActivity, private val expenses : MutableList<Expense>):RecyclerView.Adapter<CustomAdapter.ViewHolder>() {

    //inner class ViewHolder(view: View): RecyclerView.ViewHolder(view)
    inner class ViewHolder(val binding: ExpenseItemBinding): RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = ExpenseItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        Log.i("inCustomAdapter, in onCreateViewHolder", binding.toString())
        return ViewHolder(binding)

//        val adapterLayout = LayoutInflater.from(parent.context).inflate(R.layout.expense_item, parent, false)
//        return ViewHolder(adapterLayout)

    }

    override fun getItemCount(): Int {
        return expenses.size
    }

    @SuppressLint("NotifyDataSetChanged")
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

        val item = expenses[position]

        holder.binding.apply { ID.text = item.id.toString()
            titleID.text = item.title
            descriptionID.text = item.description
            amountID.text = item.amount.toString()
            categoryID.text = item.category
            dateID.text = item.date.toString()
            paymentMethodID.text = item.payment_method

        }

        holder.binding.deleteButton.setOnClickListener{

            Log.i("in deletebutton binding", "del button pushed")
            val dialog = Dialog(context)
            dialog.setCancelable(true)
            dialog.setContentView(R.layout.delete_popup)

            val titleLabel = dialog.findViewById(R.id.titleLabel) as TextView

            var expenseTitle = expenses.get(position).title
            expenseTitle+=" ?"

            titleLabel.text = expenseTitle


            val yesView = dialog.findViewById(R.id.yesButton) as View
            Log.i("yedView", yesView.toString())
            val noView = dialog.findViewById(R.id.noButton) as View



            yesView.setOnClickListener{
                Log.i("yes view", "clicked")
                Log.i("position = ", position.toString())
                expenses.removeAt(position)
                Log.i("in CUstomer adapter, removed expense", expenses.toString())
                //notifyDataSetChanged()
                notifyItemRemoved(position)
                dialog.dismiss()
            }

            noView.setOnClickListener{
                dialog.dismiss()
            }

            dialog.show()

        }

        holder.binding.editButton.setOnClickListener(){

            /*val bundle = Bundle()
            val intent = Intent(context, EditExpenseActivity::class.java)

            bundle.putParcelable("expense", expenses[position])
            intent.putExtra("expenseBundle", bundle)


            context.startActivityForResult(intent, 5)*/

            val bundle = Bundle()
            val intent = Intent(context, EditExpenseActivity::class.java)
            bundle.putSerializable("expense", expenses[position] as Serializable)
            intent.putExtra("expenseBundle", bundle)
            context.startActivityForResult(intent, 5)

            //in receiving activty
            /*val receivedBundle = intent.getBundleExtra("expenseBundle")
            val receivedExpense = receivedBundle?.getSerializable("expense") as? Expense*/


        }
    }



}