package com.example.mobilegemscollection

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.mobilegemscollection.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity(), GemItemClickListener {
    private lateinit var binding: ActivityMainBinding
    private lateinit var gemViewModel: GemViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        gemViewModel = ViewModelProvider(this).get(GemViewModel::class.java)
        binding.newGemButton.setOnClickListener {
            NewGemSheet(null).show(supportFragmentManager, "newGemTag")
        }
        setRecyclerView()
    }

    private fun setRecyclerView() {
        val mainActivity = this
        gemViewModel.gemItems.observe(this) {
            binding.gemsCollectionRecyclerView.apply {
                layoutManager = LinearLayoutManager(applicationContext)
                adapter = GemItemAdapter(it, mainActivity)
            }
        }
    }

    override fun editGemItem(gemItem: GemItem) {
        NewGemSheet(gemItem).show(supportFragmentManager, "newGemTag")
    }
}







