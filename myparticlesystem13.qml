import QtQuick 2.0
import QtQuick.Particles 2.12

Rectangle {
    width: 1200
    height: 660
    color: "black"
    ParticleSystem {
        anchors.fill: parent
        id: syssy
        //! [0]
        ParticleGroup {               // 将下面定义的图像粒子"fire"添加进一个粒子组
            name: "fire"
            duration: 2000
            durationVariation: 2000   // 经过(0,4)秒后，进入"splode"状态
            to: {"splode":1}
        }
        //! [0]
        //! [1]
        ParticleGroup {
            name: "splode"           // "splode"同样在下方定义
            duration: 400            // 0.4秒后进入"dead"状态
            to: {"dead":1}
            TrailEmitter {                 // 该粒子带有一个TrailEmitter，用来发射"works"粒子以跟随"splode"粒子，形成烟花的尾焰效果
                group: "works"
                emitRatePerParticle: 100   // 跟随比例
                lifeSpan: 1000
                maximumEmitted: 1200
                size: 8
                velocity: AngleDirection {angle: 270; angleVariation: 45; magnitude: 20; magnitudeVariation: 20;}
                acceleration: PointDirection {y:100; yVariation: 20}     // 向四周扩散并向下飘落
            }
        }
        //! [1]
        //! [2]
        ParticleGroup {             // 在"dead"状态调用worksEmitter向四周发射爆裂的烟花
            name: "dead"
            duration: 1000
            Affector {
                once: true
                onAffected: worksEmitter.burst(400,x,y)  // 这里的x，y是当前这个ParticleGroup的坐标值
            }
        }
        //! [2]

        Timer {                                 // 间隔6秒的定时器，用来调用第一个Emitter
            interval: 2000
            running: true
            triggeredOnStart: true
            repeat: true
            onTriggered:startingEmitter.pulse(100); // burst为一次使能，而pulse为一段时间使能
        }
        Emitter {
            id: startingEmitter                    // 上升火焰发射器
            group: "fire"
            width: parent.width
            y: parent.height
            enabled: false
            emitRate: 100
            lifeSpan: 3000
            velocity: PointDirection {y:-100;}
            size: 50
        }

        Emitter {                               // 爆裂火焰发射器
            id: worksEmitter
            group: "works"
            enabled: false
            emitRate: 100
            lifeSpan: 5000
            maximumEmitted: 6400
            size: 50
            endSize: 5
            velocity: CumulativeDirection {
                PointDirection {y:-100}
                AngleDirection {angleVariation: 360; magnitudeVariation: 160;}
            }
            acceleration: PointDirection {y:100; yVariation: 20}
        }

        ImageParticle {
            groups: ["works", "fire", "splode"]
            source: "qrc:///particleresources/star.png"
            //source: "./snowflake.png"
            colorVariation: 1.0
            color: "white"
            //autoRotation: true
//            SequentialAnimation on color {                  // 在颜色上增加动画
//                loops: Animation.Infinite                   // 无限循环。等同-1，假设是正值则循环详细次数
//                ColorAnimation {                            // 颜色动画
//                    from: "white"
//                    to: "blue"
//                    duration: 4000
//                }
//                ColorAnimation {
//                    from: "blue"
//                    to: "violet"
//                    duration: 500
//                }
//                ColorAnimation {
//                    from: "violet"
//                    to: "cyan"
//                    duration: 500
//                }
//            }
            entryEffect: ImageParticle.Scale                   // 为粒子的进入与消失添加尺寸的变化，进入与消失时尺寸为0
        }
    }
}
