import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import org.gradle.api.tasks.compile.JavaCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // ✅ Force Kotlin compile target to Java 11
    tasks.withType<KotlinCompile>().configureEach {
        kotlinOptions {
            jvmTarget = "11"
        }
    }

    // ✅ Force Java compile target to Java 11
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "11"
        targetCompatibility = "11"
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    project.evaluationDependsOn(":app")

    // ✅ PAKSA ulang lagi dalam subprojects biar QR Scanner & plugin lain tunduk
    tasks.withType<KotlinCompile>().configureEach {
        kotlinOptions.jvmTarget = "11"
    }

    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "11"
        targetCompatibility = "11"
    }

    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
