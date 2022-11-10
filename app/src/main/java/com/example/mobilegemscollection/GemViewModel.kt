package com.example.mobilegemscollection

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import java.util.*

class GemViewModel : ViewModel() {
    var gemItems = MutableLiveData<MutableList<GemItem>>()

    init {
        gemItems.value = mutableListOf()
    }

    fun addTaskItem(newTask: GemItem) {
        val list = gemItems.value
        list!!.add(newTask)
        gemItems.postValue(list)
    }

    fun updateTaskItem(
        id: UUID,
        name: String,
        desc: String?,
        colour: String?,
        hardness: String?,
        birthstone: String?
    ) {
        val list = gemItems.value
        val task = list!!.find { it.id == id }!!
        task.name = name
        task.desc = desc
        task.colour = colour
        task.hardness = hardness
        task.birthstone = birthstone
        gemItems.postValue(list)
    }
}