import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    color: "red"                                   // 一种比較浓郁的黄色
    width: 400
    height: 400
    ParticleSystem {
        width: 200                                      // 我们相同能够设置粒子系统的尺寸
        height: 200
        anchors.centerIn: parent

        ImageParticle {
            source: "qrc:///particleresources/glowdot.png"   // 假设使用star，更有一种流水的波光凌凌的感觉
            z: 2                                          // z属性继承自item，相同为了保证粒子不被覆盖。这里能够不写
            anchors.fill: parent
            color: "#336666CC"                           // 定义了一个ARGB的颜色值，33为透明度，00-FF透明度逐渐减少。这样不用再额外设置alpha
            colorVariation: 0.0                          // 保证粒子色彩一致
        }

        Emitter {
            anchors.fill: parent
            emitRate: 10000
            lifeSpan: 500
            size: 8
            //! [0]
            shape: MaskShape {                         // shape属性能够定义为直线，椭圆以及这里的MaskShape，这样Emitter会将粒子随机发射到规定的形状区域内
                source: "./heart.png" // 这里我们能够使用自己的图片，使用绝对路径或是相对路径
            }
            //velocity: PointDirection {y: 20;/*y: 240*/}
        }

    }
}
