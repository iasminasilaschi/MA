package com.example.mobilegemscollection

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.mobilegemscollection.databinding.TaskItemCellBinding

class GemItemAdapter(
    private val gemItems: List<GemItem>,
    private val clickListener: GemItemClickListener
) : RecyclerView.Adapter<GemItemViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): GemItemViewHolder {
        val from = LayoutInflater.from(parent.context)
        val binding = TaskItemCellBinding.inflate(from, parent, false)
        return GemItemViewHolder(parent.context, binding, clickListener)
    }

    override fun onBindViewHolder(holder: GemItemViewHolder, position: Int) {
        holder.bindTaskItem(gemItems[position])
    }

    override fun getItemCount(): Int = gemItems.size
}