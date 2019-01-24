import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {                                             // 矩形根元素
    id: root
    width: 1920
    height: 720

    gradient: Gradient {                                // 增加渐变效果
        GradientStop { position: 0; color: "#000030" }
        GradientStop { position: 1; color: "#000000" }
    }
    ParticleSystem { id: sys1 }
    ImageParticle {                                     // 也是粒子系统的基本元素
        system: sys1                                    // 指明系统
        source: "qrc:///particleresources/star.png"     // 这里选用了“光点”粒子。详细内容见下方第（1）点
        color: "cyan"                                   // 颜色
        alpha: 0                                        // 透明度
        SequentialAnimation on color {                  // 在颜色上增加动画
            loops: Animation.Infinite                   // 无限循环。等同-1，假设是正值则循环详细次数
            ColorAnimation {                            // 颜色动画
                from: "cyan"
                to: "blue"
                duration: 1000
            }
            ColorAnimation {
                from: "blue"
                to: "violet"
                duration: 2000
            }
            ColorAnimation {
                from: "violet"
                to: "cyan"
                duration: 2000
            }
        }
        colorVariation: 0.3                             // 颜色变化率。从0到1，越大粒子群的色彩越丰富
    }
    Emitter {                                           // 这就是我们的发射器了
        id: trailsNormal
        system: sys1                                   // 一样要指明详细的粒子系统

        width: 20
        height: 20
        emitRate: 1000                                  // 每秒粒子发射数
        lifeSpan: 2000                                  // 粒子生命周期(毫秒)

        enabled: false
        velocity: AngleDirection {
            angle:0
            angleVariation: 360
            magnitude: 40
        }
        acceleration: AngleDirection {
            angle: 20
            angleVariation: 360
            magnitude: 100
        }

        size: 50                                                            // 粒子大小，单位是像素，默觉得16
        sizeVariation: 4                                                    // 一个会随机加到size和endSize上的增量
        endSize: 10

        shape: EllipseShape {
        }

        PathAnimation {
            id: idpathanimal
            target: trailsNormal
            //anchorPoint: "0,0"
            duration: 3000
            orientationEntryDuration: 200
            orientationExitDuration: 200
            running: true
            //loops: Animation.Infinite
            onStarted: {
                trailsNormal.enabled = true;
            }
            //orientation: PathAnimation.RightFirst

            path: Path {
                startX: 960; startY: 720

                PathArc {
                    x: 960; y: 180
                    radiusX: 270; radiusY: 270
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathArc {
                    x: 960; y: 540
                    radiusX: 180; radiusY: 180
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathArc {
                    x: 960; y: 360
                    radiusX: 90; radiusY: 90
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    x: -200; y: 360
                }
            }
        }
    }

    ParticleSystem { id: sys2 }
    ImageParticle {                                     // 也是粒子系统的基本元素
        system: sys2                                  // 指明系统
        source: "qrc:///particleresources/star.png"     // 这里选用了“光点”粒子。详细内容见下方第（1）点
        color: "cyan"                                   // 颜色
        alpha: 0                                        // 透明度
        SequentialAnimation on color {                  // 在颜色上增加动画
            loops: Animation.Infinite                   // 无限循环。等同-1，假设是正值则循环详细次数
            ColorAnimation {                            // 颜色动画
                from: "cyan"
                to: "blue"
                duration: 1000
            }
            ColorAnimation {
                from: "blue"
                to: "violet"
                duration: 2000
            }
            ColorAnimation {
                from: "violet"
                to: "cyan"
                duration: 2000
            }
        }
        colorVariation: 0.3                             // 颜色变化率。从0到1，越大粒子群的色彩越丰富
    }
    Emitter {                                           // 这就是我们的发射器了
        id: trailsNormal2
        system: sys2                                 // 一样要指明详细的粒子系统

        width: 20
        height: 20
        emitRate: 1000                                  // 每秒粒子发射数
        lifeSpan: 2000                                  // 粒子生命周期(毫秒)

        enabled: false
        velocity: AngleDirection {
            angle:0
            angleVariation: 360
            magnitude: 40
        }
        acceleration: AngleDirection {
            angle: 20
            angleVariation: 360
            magnitude: 100
        }
        //velocityFromMovement: 8                                           // 基于当前粒子的运动为其增加一个额外的速度向量

        size: 50                                                            // 粒子大小，单位是像素，默觉得16
        sizeVariation: 4                                                    // 一个会随机加到size和endSize上的增量
        endSize: 10

        shape: EllipseShape {
        }

        PathAnimation {
            id: idpathanimal2
            target: trailsNormal2
            //anchorPoint: "0,0"
            duration: 3000
            orientationEntryDuration: 200
            orientationExitDuration: 200
            running: true
            //loops: Animation.Infinite
            onStarted: {
                trailsNormal2.enabled = true;
            }
            //orientation: PathAnimation.RightFirst

            path: Path {
                startX: 960; startY: 0

                PathArc {
                    x: 960; y: 540
                    radiusX: 270; radiusY: 270
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathArc {
                    x: 960; y: 180
                    radiusX: 180; radiusY: 180
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathArc {
                    x: 960; y: 360
                    radiusX: 90; radiusY: 90
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    x: 2120;y: 360
                }
            }
        }
    }

    Text {
        property int rates: 1

        id: idlogo
        anchors.centerIn: parent
        color: "#e9e9d8"
        visible: false
        font.pixelSize: 200
        font.bold: true
        text: qsTr("ITAS")
        scale: 0.0

        Behavior on scale {
            NumberAnimation {
                duration: 1000
            }
        }
    }

    Timer {
        interval: 2000
        repeat: false
        running: true
        onTriggered: {
            idlogo.visible = true;
            idlogo.scale = 1;
        }
    }
}
