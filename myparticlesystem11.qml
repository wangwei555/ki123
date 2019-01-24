import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    width: 360
    height: 540
    color: "black"
    ParticleSystem {                                  // 第一束红色粒子
        anchors.fill: parent
        ImageParticle {
            groups: ["A"]
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            color:"#FF1010"
            redVariation: 0.8                          // 形成"明红"到"暗红"的颜色差异
        }

        Emitter {
            group: "A"
            emitRate: 100
            lifeSpan: 2800
            size: 32
            sizeVariation: 8
            velocity: PointDirection{ x: 66; xVariation: 20 }
            width: 80                                      // 产生粒子的区域是(0,0)到(80,80)的矩形范围
            height: 80
        }

        //! [A]
        Affector {
            groups: ["A"]                                  // Affector作用于A
            x: 120                                         // 影响区域
            width: 80
            height: 80
            once: true
            position: PointDirection { x: 120; }            // x 增加120
        }
        //! [A]

        ImageParticle {                                     // 第二束绿色粒子
            groups: ["B"]
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            color:"#10FF10"
            greenVariation: 0.8
        }

        Emitter {
            group: "B"
            emitRate: 100
            lifeSpan: 2800
            size: 32
            sizeVariation: 8
            velocity: PointDirection{ x: 240; xVariation: 60 }
            y: 260
            width: 10
            height: 10
        }

        //! [B]
        Affector {
            groups: ["B"]
            x: 120
            y: 240
            width: 80
            height: 80
            once: true
            velocity: AngleDirection { angleVariation:360; magnitude: 72 } // 角度变化范围和强度
        }
        //! [B]

        ImageParticle {                                      // 第三束蓝色粒子
            groups: ["C"]
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            color:"#1010FF"
            blueVariation: 0.8
        }

        Emitter {
            group: "C"
            y: 400
            emitRate: 100
            lifeSpan: 2800
            size: 32
            sizeVariation: 8
            velocity: PointDirection{ x: 80; xVariation: 10 }
            acceleration: PointDirection { y: 10; x: 20; }
            width: 80
            height: 80
        }

        //! [C]
        Affector {
            groups: ["C"]
            x: 120
            y: 400
            width: 80
            height: 120
            once: true
            relative: false
            acceleration: PointDirection { y: -80; }         // 在y方向的加速度下降80
        }
        //! [C]

    }
}
