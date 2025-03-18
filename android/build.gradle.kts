allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// تعيين مسار مجلد البناء الجديد
rootProject.buildDir = file("../build")

subprojects {
    buildDir = file("${rootProject.buildDir}/${project.name}")
}

subprojects {
    evaluationDependsOn(":app")
}

// تنظيف المشروع
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
