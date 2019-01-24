import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    color: "black"
    width: 360
    height: 540
    ParticleSystem {
        id: sys
        anchors.fill: parent
        onEmptyChanged: if (empty) sys.pause();  // empty是ParticleSystem的一个属性，当该系统中没有“活着”的粒子时，这个值为true。显而易见，onEmptyChanged则是该属性所绑定的一个槽函数（QML 中叫Handler，处理者）。当没有粒子显示时。我们将该系统暂停以节省资源。
        ImageParticle {
            system: sys
            id: cp
            source: "qrc:///particleresources/glowdot.png"
            colorVariation: 0.4
            color: "#000000FF"                 // 这里将粒子设置为全透明的蓝色，但因为上的的0.4。因此粒子群并非全蓝的
        }

        Emitter {
            //burst on click
            id: bursty
            system: sys                 // 因为这里的Emitter被ParticleSystem包括，这句并非必须的
            enabled: ma.pressed         // 将enabled与pressed信号绑定，当按键或手指抬起Emitter即停止
            x: ma.mouseX
            y: ma.mouseY
            emitRate: 16000
            maximumEmitted: 4000        // 最大的粒子数为4000个，假设屏蔽这句话，按住鼠标不松开，粒子会被持续发射。而不是如今这样一圈接一圈
            acceleration: AngleDirection {angleVariation: 360; magnitude: 360; }  // 360度方向，距离360
            size: 8
            endSize: 16
            sizeVariation: 4
        }

        MouseArea {
            anchors.fill: parent
            onPressed: sys.resume()
            id: ma
        }
    }
}
