package com.example.mobilegemscollection

import android.os.Bundle
import android.text.Editable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import com.example.mobilegemscollection.databinding.FragmentNewTaskSheetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class NewGemSheet(var gemItem: GemItem?) : BottomSheetDialogFragment() {
    private lateinit var binding: FragmentNewTaskSheetBinding
    private lateinit var taskViewModel: GemViewModel

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activity = requireActivity()

        if (gemItem != null) {
            binding.gemTitle.text = "Edit Gem"
            val editable = Editable.Factory.getInstance()
            binding.name.text = editable.newEditable(gemItem!!.name)
            binding.desc.text = editable.newEditable(gemItem!!.desc)
        } else {
            binding.gemTitle.text = "New Gem"
        }

        taskViewModel = ViewModelProvider(activity).get(GemViewModel::class.java)
        binding.saveButton.setOnClickListener {
            saveAction()
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentNewTaskSheetBinding.inflate(inflater, container, false)
        return binding.root
    }


    private fun saveAction() {
        val name = binding.name.text.toString()
        val desc = binding.desc.text.toString()
        val colour = binding.colour.text.toString()
        val hardness = binding.hardness.text.toString()
        val birthstone = binding.birthstone.text.toString()

        if (gemItem == null) {
            val newGem = GemItem(name, desc, colour, hardness, birthstone)
            taskViewModel.addTaskItem(newGem)
        } else {
            taskViewModel.updateTaskItem(gemItem!!.id, name, desc, colour, hardness, birthstone)
        }
        binding.name.setText("")
        binding.desc.setText("")
        binding.colour.setText("")
        binding.hardness.setText("")
        binding.birthstone.setText("")
        dismiss()
    }

}








