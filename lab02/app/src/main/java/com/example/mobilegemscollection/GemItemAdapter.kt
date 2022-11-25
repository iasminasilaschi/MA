package com.example.mobilegemscollection

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.mobilegemscollection.databinding.GemItemCellBinding

class GemItemAdapter(
    private val gemItems: List<GemItem>,
    private val clickListener: GemItemClickListener
) : RecyclerView.Adapter<GemItemViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): GemItemViewHolder {
        val from = LayoutInflater.from(parent.context)
        val binding = GemItemCellBinding.inflate(from, parent, false)
        return GemItemViewHolder(parent.context, binding, clickListener)
    }

    override fun onBindViewHolder(holder: GemItemViewHolder, position: Int) {
        holder.bindGemItem(gemItems[position])
    }

    override fun getItemCount(): Int = gemItems.size
}