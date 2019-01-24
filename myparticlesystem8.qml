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
                to: "magenta"
                duration: 1000
            }
            ColorAnimation {
                from: "magenta"
                to: "blue"
                duration: 2000
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
        lifeSpan: 1000                                  // 粒子生命周期(毫秒)

        enabled: false

//        y: circle.cy-10                               // 发射到的坐标值
//        x: circle.cx-10                               // 这里使用mouseArea检測是否按下。有则使用按下的坐标，否则使用以下的计算坐标。这里的粒子之所以能够持续的发射，其缘由正是QML的属性绑定，由于这个坐标值的持续变化。造成了我们所见的粒子动画。

//        x: root.width / 2
//        y: root.height / 2

//        x: 300
//        y: 320

        //velocity: PointDirection {xVariation: 4; yVariation: 4;}          // 当粒子产生后。其扩散行为在x,y方向上的速度
        //acceleration: PointDirection {xVariation: 10; yVariation: 10;}    // 扩散行为的加速度
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
            id: idpathanimal
            target: trailsNormal
            //anchorPoint: "0,0"
            duration: 1500
            orientationEntryDuration: 200
            orientationExitDuration: 200
            running: true
            loops: Animation.Infinite
            onStarted: {
                trailsNormal.enabled = true;
            }
            //orientation: PathAnimation.RightFirst

            path: Path {
                startX: 360; startY: 360

                PathArc {
                    x: 1620; y: 360
                    radiusX: 600; radiusY: 200
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
                PathArc {
                    x: 360; y: 360
                    radiusX: 600; radiusY: 200
                    useLargeArc: true
                    direction: PathArc.Counterclockwise
                }
            }
        }
    }



//    Item {                                                                  // 我们能够使用Item来包括一个逻辑对象，并为它命名。定义其属性来进行调用
//        id: circle
//        //anchors.fill: parent
//        property real radius: 0                                             // 定义属性radius
//        property real dx: root.width / 2                                    // 圆心横坐标dx
//        property real dy: root.height / 2                                   // 圆心纵坐标dy
//        property real cx: 640 * Math.sin(percent*6.283185307179) + dx       // 计算当前横坐标cx
//        property real cy: 180 * Math.cos(percent*6.283185307179) + dy       // 计算当前纵坐标cy
//        property real percent: 0                                            // 百分比percent

//        SequentialAnimation on percent {                                    // 使用连续动画改变<span style="font-family: Arial, Helvetica, sans-serif;">自己定义属性percent</span>

////            loops: Animation.Infinite
//            running: true
////            NumberAnimation {                                             // 数值动画，注意到这里的往复动画会使粒子顺时针、逆时针交替运动。实际效果也是如此
////            duration: 1000
////            from: 1
////            to: 0
////            loops: 2
////            }
//            NumberAnimation {
//            duration: 1000
//            from: 0
//            to: 1
//            loops: 1
//            }

//        }

////        SequentialAnimation on radius {                // 半径的动画
////            loops: Animation.Infinite
////            running: true
////            NumberAnimation {
////                duration: 4000
////                from: 0
////                to: 320
////            }
////            NumberAnimation {
////                duration: 4000
////                from: 320
////                to: 0
////            }
////        }
//    }
}
