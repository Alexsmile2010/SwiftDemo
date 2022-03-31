//
//  DGTXImageView.swift
//  DGTX
//
//  Created by Alexey Zayakin on 12.05.2021.
//

import UIKit


// MARK: - DGTXImageView

class DGTXImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    init(withPresetImage preset: DGTXImageViewPresetImages, renderMode: UIImage.RenderingMode = .alwaysTemplate) {
        super.init(frame: .zero)
        setupView()
        applyImagePreset(preset, renderMode: renderMode)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyImagePreset(_ preset: DGTXImageViewPresetImages, renderMode: UIImage.RenderingMode = .alwaysTemplate) {
        image = preset.image?.withRenderingMode(renderMode)
    }
    
    private func setupView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}

extension DGTXImageView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}


// MARK: - DGTXImageViewConfigurator

protocol DGTXImageViewConfigurator: ViewConfigurator {
    var image: UIImage? { get set }
    var contentMode: UIView.ContentMode { get set }
    
    func setImage(preset: DGTXImageViewPresetImages)
}

extension DGTXImageViewConfigurator where Self: UIImageView {
    func setImage(preset: DGTXImageViewPresetImages) {
        self.image = preset.image
    }
}

extension DGTXImageView: DGTXImageViewConfigurator {
    convenience init(_ configurator: (_ imageView: DGTXImageViewConfigurator) -> Void) {
        self.init()
        configurator(self)
    }
}
