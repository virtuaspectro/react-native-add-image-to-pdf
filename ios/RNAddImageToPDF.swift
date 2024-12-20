import Foundation
import PDFKit

@objc(RNAddImageToPDF)
class RNAddImageToPDF: NSObject {

  @objc(loadImageToPDF:imagePath:x:y:width:height:resolver:rejecter:)
  func loadImageToPDF(pdfPath: String, imagePath: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    guard let pdfDocument = PDFDocument(url: URL(fileURLWithPath: pdfPath)),
          let image = UIImage(contentsOfFile: imagePath),
          let pdfPage = pdfDocument.page(at: 0) else {
      rejecter("error", "Failed to load PDF or image", nil)
      return
    }

    let imageAnnotation = ImageStamp(with: image, forBounds: CGRect(x: x, y: y, width: width, height: height), withProperties: nil)
    pdfPage.addAnnotation(imageAnnotation)

    do {
      try pdfDocument.write(to: URL(fileURLWithPath: pdfPath))
      resolver(pdfPath)
    } catch {
      rejecter("error", "Failed to save PDF", error)
    }
  }
}

class ImageStamp: PDFAnnotation {

  var image: UIImage!

  init(with image: UIImage!, forBounds bounds: CGRect, withProperties properties: [AnyHashable : Any]?) {
      super.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp, withProperties: properties)
      self.image = image
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func draw(with box: PDFDisplayBox, in context: CGContext) {
      guard let cgImage = self.image.cgImage else { return }
      context.draw(cgImage, in: self.bounds)

  }
}
