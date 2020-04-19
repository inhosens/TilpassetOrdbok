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

void QShareActivity::setSharedString(const QString &sstring)
{
    if (m_sharedString == sstring)
        return;
    //qDebug() << "TilpassetOrdbok QShareActivity::setSharedString :" << sstring;
    m_sharedString = sstring;
    emit sharedStringChanged();
}

#if defined(Q_OS_ANDROID)
void QShareActivity::onApplicationStateChanged(Qt::ApplicationState applicationState)
{
    if(applicationState == Qt::ApplicationState::ApplicationSuspended) {
        // nothing to do
        return;
    }
    if(applicationState == Qt::ApplicationState::ApplicationActive) {
        if(!mPendingIntentsChecked) {
            mPendingIntentsChecked = true;
            QAndroidJniObject activity = QtAndroid::androidActivity();
            if(activity.isValid()) {
                activity.callMethod<void>("checkPendingIntents");
                return;
            }
        }
    }
}
#endif

QString QShareActivity::sharedString() const
{
    return m_sharedString;
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
    Q_UNUSED (obj)
    QShareActivity::getInstance()->setSharedString(textStr);
    env->ReleaseStringUTFChars(text, textStr);
    return;
}
#ifdef __cplusplus
}
#endif
#endif

