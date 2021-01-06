@IsTest
private class SObjPicklist_T {
    @IsTest
    static void validPicklist() {
        System.assertEquals('Task', new TaskPicklists().TaskSubType.Taskx.value, 'picklist option should be Task');
    }

    @IsTest
    static void invalidPicklist() {
        try {
            String value = new TaskPicklists().TaskSubType_Invalid.Taskx.value;
            System.assert(false, 'should throw exception');
        }
        catch(Exception e) { }
    }

    @IsTest
    static void getAllOptions() {
        Set<String> values = new Set<String>();

        for(SObjPicklist.Option opt : new TaskPicklists().TaskSubType.getAllOptions()) {
            values.add(opt.value);
        }

        System.assert(values.contains('Task'), 'picklist options should contain Task');
    }

    @IsTest
    static void getActiveOptions() {
        Set<String> values = new Set<String>();

        for(SObjPicklist.Option opt : new TaskPicklists().TaskSubType.getActiveOptions()) {
            values.add(opt.value);
        }

        System.assert(values.contains('Task'), 'picklist options should contain Task');
    }
    
    public class TaskPicklists {
        public TaskSubType TaskSubType {
            private set;
            public get { if(TaskSubType == null) TaskSubType = new TaskSubType(); return TaskSubType; }
        }

        public TaskSubType_Invalid TaskSubType_Invalid {
            private set;
            public get { if(TaskSubType_Invalid == null) TaskSubType_Invalid = new TaskSubType_Invalid(); return TaskSubType_Invalid; }
        }
    }

    public class TaskSubtype extends SObjPicklist {
        public final SObjPicklist.Option Taskx;

        public TaskSubType() {
            super(Task.TaskSubtype);
            this.Taskx = this.getOption('Task');
        }
    }

    public class TaskSubtype_Invalid extends SObjPicklist {
        public final SObjPicklist.Option Taskx;

        public TaskSubtype_Invalid() {
            super(Task.TaskSubtype);
            this.Taskx = this.getOption('Invalid-123');
        }
    }
}