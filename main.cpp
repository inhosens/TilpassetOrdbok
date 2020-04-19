#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
//#include <qtwebengineglobal.h>
#include <QtWebView>
//#include <QtQuick>

#include <QQmlContext>
#include "qshareactivity.h"
#if defined(Q_OS_ANDROID)
/*
#include <QtAndroid>
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>

static void fromOTherApp(JNIEnv *env, jobject thiz, jstring text)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    qDebug() << "C++ TilpassetOrdbok : " << text;
    const char *textStr = env->GetStringUTFChars(text, nullptr);
    qDebug() << "Test TilpassetOrdbok " << textStr;
    QShareActivity::getInstance()->setText(textStr);
    env->ReleaseStringUTFChars(text, textStr);
    return;
}

void registerNativeMethods() {
    JNINativeMethod methods[] = {
        {
            "searchFromOtherApp",
            "(Ljava/lang/String;)V",
            reinterpret_cast<void *>(fromOTherApp)
        }
    };
    QAndroidJniObject javaClass("org/inhosens/JeBros/QShareActivity");
    QAndroidJniEnvironment env;
    jclass objectClass = env->GetObjectClass(javaClass.object<jobject>());
    env->RegisterNatives(objectClass, methods, sizeof(methods) / sizeof(methods[0]));
    env->DeleteLocalRef(objectClass);
}*/
#endif

int main(int argc, char *argv[])
{
    //qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    if (qEnvironmentVariableIsEmpty("QTGLESSTREAM_DISPLAY")) {
        qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", QByteArray("213"));
        qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", QByteArray("120"));

        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    }

    QCoreApplication::setOrganizationName("JeBros");
    QCoreApplication::setOrganizationDomain("qt.io");
    QCoreApplication::setApplicationName("TilpassetOrdbok");

    QSettings settings;

    QGuiApplication app(argc, argv);
    QtWebView::initialize();
    //QtWebEngine::initialize();

    QQmlApplicationEngine engine;
#if defined(Q_OS_ANDROID)
    //registerNativeMethods();
#endif
    QShareActivity qjshare;
    // from QML we have access to ApplicationUI as myApp
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("qjShare", &qjshare);
#if defined(Q_OS_ANDROID)
    QObject::connect(&app, SIGNAL(applicationStateChanged(Qt::ApplicationState)), &qjshare, SLOT(onApplicationStateChanged(Qt::ApplicationState)));
#endif
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
