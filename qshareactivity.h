#ifndef QSHAREACTIVITY_H
#define QSHAREACTIVITY_H

#include <QObject>
#include <QtQml>

#if defined(QT_OS_ANDROID)
#include <QtAndroid>
#endif
class QShareActivity : public QObject
{
    Q_OBJECT
public:
    explicit QShareActivity(QObject *parent = nullptr);

    static QShareActivity *getInstance();

    void setSharedString(const QString &text);

    Q_INVOKABLE
    QString sharedString() const;

signals:
    void sharedStringChanged();

public slots:
#if defined(Q_OS_ANDROID)
    void onApplicationStateChanged(Qt::ApplicationState applicationState);
#endif

private:
    QString m_sharedString;
#if defined(Q_OS_ANDROID)
    bool mPendingIntentsChecked = false;
#endif

    static QShareActivity *m_instance;

};
#endif // QSHAREACTIVITY_H
