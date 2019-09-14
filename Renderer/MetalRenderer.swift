//
//  MetalRenderer.swift
//
//  Created by Shuichi Tsutsumi on 2018/08/29.
//  Copyright © 2018 Shuichi Tsutsumi. All rights reserved.
//

import Metal
import MetalKit

// The max number of command buffers in flight
let kMaxBuffersInFlight: Int = 1

// Vertex data for an image plane
let kImagePlaneVertexData: [Float] = [
    -1.0, -1.0,  0.0, 1.0,
    1.0, -1.0,  1.0, 1.0,
    -1.0,  1.0,  0.0, 0.0,
    1.0,  1.0,  1.0, 0.0,
]

class MetalRenderer {
    private let device: MTLDevice
    private let inFlightSemaphore = DispatchSemaphore(value: kMaxBuffersInFlight)
    private var renderDestination: MTKView
    
    private var commandQueue: MTLCommandQueue!
    private var vertexBuffer: MTLBuffer!
    
    init(metalDevice device: MTLDevice, renderDestination: MTKView) {
        self.device = device
        self.renderDestination = renderDestination
        
        // Set the default formats needed to render
        self.renderDestination.colorPixelFormat = .bgra8Unorm
        self.renderDestination.sampleCount = 1
        
        commandQueue = device.makeCommandQueue()
                
        // prepare vertex buffer(s)
        let imagePlaneVertexDataCount = kImagePlaneVertexData.count * MemoryLayout<Float>.size
        vertexBuffer = device.makeBuffer(bytes: kImagePlaneVertexData, length: imagePlaneVertexDataCount, options: [])
        vertexBuffer.label = "vertexBuffer"        
    }
    
    private let ciContext = CIContext()
    private let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    func update(with ciImage: CIImage) {
        // Wait to ensure only kMaxBuffersInFlight are getting proccessed by any stage in the Metal
        // pipeline (App, Metal, Drivers, GPU, etc)
        let _ = inFlightSemaphore.wait(timeout: .distantFuture)
        
        guard
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let currentDrawable = renderDestination.currentDrawable
            else {
                inFlightSemaphore.signal()
                return
        }
        commandBuffer.label = "MyCommand"
        
        commandBuffer.addCompletedHandler{ [weak self] commandBuffer in
            if let strongSelf = self {
                strongSelf.inFlightSemaphore.signal()
            }
        }
        ciContext.render(ciImage, to: currentDrawable.texture, commandBuffer: commandBuffer, bounds: ciImage.extent, colorSpace: colorSpace)
        
        commandBuffer.present(currentDrawable)
        commandBuffer.commit()
    }
}
