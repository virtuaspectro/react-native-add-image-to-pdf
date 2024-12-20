package com.virtuaspectro.addimagetopdf

import android.graphics.BitmapFactory
import android.graphics.RectF
import com.facebook.react.bridge.*
import com.facebook.react.module.annotations.ReactModule
import com.tom_roush.pdfbox.pdmodel.PDDocument
import com.tom_roush.pdfbox.pdmodel.PDPage
import com.tom_roush.pdfbox.pdmodel.graphics.image.LosslessFactory
import com.tom_roush.pdfbox.pdmodel.PDPageContentStream
import java.io.File
import java.io.IOException

@ReactModule(name = RNAddImageToPDF.NAME)
class RNAddImageToPDF(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    companion object {
        const val NAME = "RNAddImageToPDF"
    }

    override fun getName(): String {
        return NAME
    }

    @ReactMethod
    fun loadImageToPDF(pdfPath: String, imagePath: String, x: Float, y: Float, width: Float, height: Float, promise: Promise) {
        try {
            val pdfFile = File(pdfPath)
            val pdfDocument = PDDocument.load(pdfFile)
            val imageFile = File(imagePath)
            val bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
            val pdfImage = LosslessFactory.createFromImage(pdfDocument, bitmap)

            val page: PDPage = pdfDocument.getPage(0)
            val contentStream = PDPageContentStream(pdfDocument, page, PDPageContentStream.AppendMode.APPEND, true, true)

            val lowerLeftX = x
            val lowerLeftY = y
            val upperRightX = x + width
            val upperRightY = y + height

            contentStream.drawImage(pdfImage, lowerLeftX, lowerLeftY, upperRightX - lowerLeftX, upperRightY - lowerLeftY)
            contentStream.close()

            pdfDocument.save(pdfFile.absolutePath)
            pdfDocument.close()

            promise.resolve(pdfPath)
        } catch (e: IOException) {
            promise.reject("error", "Failed to load image into PDF", e)
        }
    }
}
