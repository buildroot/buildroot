import farama_notifications

NOTIFICATION_ID = "test_event_occurrence"
NOTIFICATION_MESSAGE = "A test event has occurred in Buildroot environment!"

farama_notifications.notifications[NOTIFICATION_ID] = NOTIFICATION_MESSAGE
