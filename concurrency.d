//Not mine
import  core.thread,
        core.sync.mutex,
        std.c.stdio,
        std.stdio;

class Swarm{
    ThreadGroup group;
    Mutex mutex;
    auto numThreads = 1;
    void delegate ()[int] jobs;
    this(void delegate()[int] aJobs, int aNumThreads){
        jobs = aJobs;
        numThreads = aNumThreads;
        group = new ThreadGroup;
        mutex = new Mutex();
    }
    void runBlocking(){
        run();
        group.joinAll();
    }
    void run(){
        foreach(c;0..numThreads)
            group.create( &swarmJobs );
    }
    void swarmJobs(){
        void delegate () myJob;
        do{
            myJob = null;
            synchronized(mutex){
                if(jobs.length > 0)
                    foreach(i,job;jobs){
                        myJob = job;
                        jobs.remove(i);
                        break;
                    }
            }
            if(myJob)
                myJob();
        }while(myJob)
    }
}
class Jobs{
    void job1(){
        foreach(c;0..1000){
            foreach(j;0..2_000_000){}
            writef("1");
            fflush(core.stdc.stdio.stdout);
        }
    }
    void job2(){
        foreach(c;0..1000){
            foreach(j;0..1_000_000){}
            writef("2");
            fflush(core.stdc.stdio.stdout);
        }
    }
}
void main(){
    auto jobs = new Jobs();
    void delegate ()[int] jobsList = 
         [1:&jobs.job1,2:&jobs.job2,3:&jobs.job1,4:&jobs.job2];
    int numThreads = 2;
    auto swarm = new Swarm(jobsList,numThreads);
    swarm.runBlocking();
    writefln("end");
}
