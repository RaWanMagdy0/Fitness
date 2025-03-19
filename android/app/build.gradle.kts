plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fitness_app"
    compileSdk = 35
    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.fitness_app"
        minSdk = 23   // تأكد من استخدام قيمة صحيحة لـ minSdk
        targetSdk = 34  // تأكد من استخدام targetSdk متوافق مع compileSdk
        versionCode = 1
        versionName = "1.0"
    }

    signingConfigs {
        create("release") {
            // إذا كنت تستخدم توقيعًا مخصصًا، أضف بيانات التوقيع هنا.
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")  // تأكد من أن التوقيع متاح
        }
    }
}

flutter {
    source = "../.."
}
