#include "qshareactivity.h"
#if defined(Q_OS_ANDROID)
#include <QtAndroid>
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#include <jni.h>
#endif
#include <QDebug>

QShareActivity *QShareActivity::m_instance = nullptr;

QShareActivity::QShareActivity(QObject *parent)
    : QObject(parent)
{
    m_instance = this;
}

QShareActivity *QShareActivity::getInstance()
{
    if (!m_instance) {
        m_instance = new QShareActivity;
        qWarning() << "QShareActivity should be instantiated !";
    }

    return m_instance;
}

void QShareActivity::setText(const QString &text)
{
    if (m_text == text)
        return;
    qDebug() << "TilpassetOrdbok c++ :" << text;
    m_text = text;
    emit textChanged();
}

QString QShareActivity::text() const
{
    return m_text;
}

#if defined(Q_OS_ANDROID)
#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT void JNICALL Java_org_inhosens_JeBros_QShareActivity_searchFromOtherApp(JNIEnv *env,
                                        jobject obj,
                                        jstring text)
{
    const char *textStr = env->GetStringUTFChars(text, nullptr);
    //qDebug() << "Test TilpassetOrdbok " << textStr;
    Q_UNUSED (obj)
    QShareActivity::getInstance()->setText(textStr);
    env->ReleaseStringUTFChars(text, textStr);
    return;
}
#ifdef __cplusplus
}
#endif
#endif

