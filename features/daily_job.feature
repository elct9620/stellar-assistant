Feature: Daily Job
  @openai
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
    And there are some news feeds
      | title                                                  | link                                               | published_at            |
      | 美國會大廈襲擊案屆3週年 3名通緝犯被捕到案              | https://www.cna.com.tw/news/aopl/202401070010.aspx | 2024-01-07 00:34:23 UTC |
      | 以色列軍方：已拆除加薩北部哈瑪斯指揮機構               | https://www.cna.com.tw/news/aopl/202401070008.aspx | 2024-01-06 21:16:14 UTC |
      | 阿拉斯加航空客機窗戶遭吹走 美監管機構下令停飛波音737-9 | https://www.cna.com.tw/news/aopl/202401070007.aspx | 2024-01-06 20:30:11 UTC |
      | 賴清德全代會訴求團結台灣 盼朝野紛爭回歸憲政體制        | https://www.cna.com.tw/news/aipl/202407210236.aspx | 2024-07-22 00:00:00 UTC |
    When the event "StellarDailyJob" is triggered
    Then the handler result should include "summaries"
    And the handler result should include "steps"
