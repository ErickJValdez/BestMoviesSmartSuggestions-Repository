public class MoviesScoreSchedule  implements Schedulable{
    public void execute(SchedulableContext sc)

    {
        MoviesCalloutsBatchApex b = new MoviesCalloutsBatchApex(); // Your batch class
        database.executeBatch(b,100);

    }

}