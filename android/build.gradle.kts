allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

//subprojects {
//    afterEvaluate { project ->
//        if (project.hasProperty("android")) {
//            project.android {
//                if (namespace == null) {
//                    namespace project.group
//                }
//            }
//        }
//    }
//}
//subprojects {
//    afterEvaluate {
//        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
//            extensions.configure<com.android.build.gradle.BaseExtension> {
//                ndkVersion = "27.0.12077973"
//            }
//        }
//    }
//}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
