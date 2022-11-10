package com.example.mobilegemscollection

import java.util.*

class GemItem(
    var name: String,
    var desc: String?,
    var colour: String?,
    var hardness: String?,
    var birthstone: String?,
    var id: UUID = UUID.randomUUID(),
) {
}