//
//  ImageOptimizer.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import UIKit
import ImageIO

struct ImageOptimizer {
	/// Compress an image data to save space.
	///
	/// Reducing the size of the image by downsampling and compressing it to JPEG at the provided parameter.
	///
	/// - Parameters:
	///   - data: The raw image Data.
	///   - maxDimension: The maximum width or height allowed in picel.
	///   - quality: Compression quality from 0.0 (max compression) to 1.0 (lossless).
	/// - Returns: The compressed image data.
	static func optimize(data: Data, maxDimension: CGFloat = 1200, quality: CGFloat = 0.7) -> Data? {
		let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
		guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
			return nil
		}
		
		let downsampleOptions = [
			kCGImageSourceCreateThumbnailFromImageAlways: true,
			kCGImageSourceShouldCacheImmediately: true,
			kCGImageSourceCreateThumbnailWithTransform: true,
			kCGImageSourceThumbnailMaxPixelSize: maxDimension
		] as [CFString : Any] as CFDictionary
		
		guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
			return nil
		}
		
		let uiImage = UIImage(cgImage: downsampledImage)
		return uiImage.jpegData(compressionQuality: quality)
	}
}
