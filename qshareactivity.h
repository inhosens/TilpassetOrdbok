#ifndef QSHAREACTIVITY_H
#define QSHAREACTIVITY_H

#include <QObject>
#if defined(QT_OS_ANDROID)
#include <QtAndroid>
#endif
class QShareActivity : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
public:
    explicit QShareActivity(QObject *parent = nullptr);

    static QShareActivity *getInstance();

    void setText(const QString &text);
    QString text() const;

signals:
    void textChanged();

private:
    QString m_text;

    static QShareActivity *m_instance;

};
#endif // QSHAREACTIVITY_H
