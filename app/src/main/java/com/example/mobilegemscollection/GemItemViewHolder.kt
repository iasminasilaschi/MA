package com.example.mobilegemscollection

import android.content.Context
import androidx.recyclerview.widget.RecyclerView
import com.example.mobilegemscollection.databinding.TaskItemCellBinding

class GemItemViewHolder(
    private val context: Context,
    private val binding: TaskItemCellBinding,
    private val clickListener: GemItemClickListener
) : RecyclerView.ViewHolder(binding.root) {

    fun bindTaskItem(taskItem: GemItem) {
        binding.name.text = taskItem.name

        binding.gemCellContainer.setOnClickListener {
            clickListener.editTaskItem(taskItem)
        }
    }
}