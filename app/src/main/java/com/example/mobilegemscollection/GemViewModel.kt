package com.example.mobilegemscollection

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import java.util.*

class GemViewModel : ViewModel() {
    var gemItems = MutableLiveData<MutableList<GemItem>>()

    init {
        gemItems.value = mutableListOf()
    }

    fun addGemItem(newGem: GemItem) {
        val list = gemItems.value
        list!!.add(newGem)
        gemItems.postValue(list)
    }

    fun updateGemItem(
        id: UUID,
        name: String,
        desc: String?,
        colour: String?,
        hardness: String?,
        birthstone: String?
    ) {
        val list = gemItems.value
        val gem = list!!.find { it.id == id }!!
        gem.name = name
        gem.desc = desc
        gem.colour = colour
        gem.hardness = hardness
        gem.birthstone = birthstone
        gemItems.postValue(list)
    }

    fun deleteItem(id: UUID) {
        val list = gemItems.value
        val gem = list!!.find { it.id == id }
        list.remove(gem)

        gemItems.postValue(list)
    }
}