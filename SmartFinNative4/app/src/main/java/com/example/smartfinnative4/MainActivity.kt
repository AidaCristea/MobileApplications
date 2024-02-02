package com.example.smartfinnative4

import android.content.Intent
import android.os.Bundle
import android.view.Window
import android.widget.Button
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.example.smartfinnative4.allExpenses.ExpensesListActivity

class MainActivity : AppCompatActivity() {
    lateinit var toplayout: LinearLayout

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //toplayout=findViewById(R.id.toplayout)

        setContentView(R.layout.activity_main)

        supportActionBar?.hide()

        val window: Window = this@MainActivity.window
        window.statusBarColor=ContextCompat.getColor(this@MainActivity, R.color.black)


        val startButton = findViewById<Button>(R.id.startButton)
        startButton.setOnClickListener{
            println("CLicked button")
            goToList()
        }


//        toplayout=findViewById(R.id.toplayout)
//        toplayout.setBackgroundColor(Color.parseColor("#C5EFCE"))
       // var textView = TextView(this)
//        textView.text=resources.getText(R.string.smart_fin)
//        textView.setTextColor(Color.parseColor("#FFFFFF"))
//        toplayout.addView(textView)
    }

    private fun goToList(){
        val intent = Intent(this, ExpensesListActivity::class.java)
        startActivity(intent)
    }
}