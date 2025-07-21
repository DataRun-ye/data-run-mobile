import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    afterEvaluate {
        if (plugins.hasPlugin("com.android.library") || plugins.hasPlugin("com.android.application")) {

            extensions.findByType<BaseExtension>()?.apply {
                if (namespace.isNullOrEmpty()) {
                    namespace = project.group.toString()
                }
            }
        }
    }
}

//subprojects {
//    afterEvaluate { project ->
//        // Check if this is an Android module
//        if (project.plugins.hasPlugin("com.android.library") ||
//            project.plugins.hasPlugin("com.android.application")) {
//
//            // Configure namespace if not already set
//            project.extensions.configure<com.android.build.gradle.BaseExtension> {
//                if (namespace == null || namespace.isEmpty()) {
//                    namespace = project.group?.toString()
//                        ?: "com.example.${project.name}"
//                }
//            }
//
//            // For each manifest-processing task, remove deprecated 'package='
//            project.tasks.matching {
//                it.name.startsWith("process") && it.name.endsWith("Manifest")
//            }.configureEach { task ->
//                task.doFirst {
//                    val mf = project.file("${project.projectDir}/src/main/AndroidManifest.xml")
//                    if (mf.exists()) {
//                        val content = mf.readText().replace(Regex("""package="[^"]*""" ), "")
//                        mf.writeText(content)
//                        println("Removed package attribute from $mf")
//                    }
//                }
//            }
//        }
//    }
//}
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
