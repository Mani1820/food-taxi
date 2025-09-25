plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

// Load key.properties
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

android {
    namespace = "com.example.food_taxi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "food_taxi"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

   signingConfigs {
    create("release") {
        val storeFilePath = keystoreProperties["storeFile"]?.toString()
            ?: throw GradleException("Missing 'storeFile' in key.properties")
        val storePassword = keystoreProperties["storePassword"]?.toString()
            ?: throw GradleException("Missing 'storePassword' in key.properties")
        val keyAlias = keystoreProperties["keyAlias"]?.toString()
            ?: throw GradleException("Missing 'keyAlias' in key.properties")
        val keyPassword = keystoreProperties["keyPassword"]?.toString()
            ?: throw GradleException("Missing 'keyPassword' in key.properties")

        storeFile = file(storeFilePath)
        this.storePassword = storePassword
        this.keyAlias = keyAlias
        this.keyPassword = keyPassword
    }
}



    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
