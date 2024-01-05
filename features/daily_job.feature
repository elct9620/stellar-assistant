@lambda
Feature: Daily Job
  Scenario: When scheduled job is trigger
    Given a event payload
      """
      {
        "version": "0",
        "id": "73659811-3cd5-4b19-a547-b152d4173d25",
        "detail-type": "Scheduled Event",
        "source": "aws.scheduler",
        "account": "123456789012",
        "time": "2024-01-05T14:25:00Z",
        "region": "ap-northeast-1",
        "resources": [
          "arn:aws:scheduler:ap-northeast-1:123456789012:schedule/default/StellarDailyJobScheduler"
        ],
        "detail": "{}"
      }
      """
    When the event "StellarDailyJob" is triggered
    Then the handler should return
      """
      { "ok": true }
      """
