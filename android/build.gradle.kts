allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    // Forzamos la dependencia de evaluación para asegurar orden
    project.evaluationDependsOn(":app")

    // En lugar de esperar al final (afterEvaluate), actuamos cuando se añade la extensión de Android
    plugins.withType<com.android.build.gradle.api.AndroidBasePlugin> {
        if (project.name == "isar_community_flutter_libs") {
            configure<com.android.build.gradle.LibraryExtension> {
                namespace = "dev.isar.isar_community_flutter_libs"
            }
        }
    }
}
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
