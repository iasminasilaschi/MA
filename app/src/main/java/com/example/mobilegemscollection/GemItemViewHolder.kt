package com.example.mobilegemscollection

import android.content.Context
import androidx.recyclerview.widget.RecyclerView
import com.example.mobilegemscollection.databinding.GemItemCellBinding

class GemItemViewHolder(
    private val context: Context,
    private val binding: GemItemCellBinding,
    private val clickListener: GemItemClickListener
) : RecyclerView.ViewHolder(binding.root) {

    fun bindGemItem(gemItem: GemItem) {
        binding.name.text = gemItem.name

        binding.gemCellContainer.setOnClickListener {
            clickListener.editGemItem(gemItem)
        }
    }
}