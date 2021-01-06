public abstract class SObjPicklist {    
    private final SObjectField field;
    private final List<String> orderedValues = new List<String>();
    private final Map<String, Option> value2Option = new Map<String, Option>();
    
    public SObjPicklist(SObjectField field) {
        this.field = field;
        
        for(PicklistEntry entry : this.field.getDescribe().getPicklistValues()) {
            this.value2Option.put(entry.getValue(), new Option(entry));
            this.orderedValues.add(entry.getValue());
        }
    }

    public Option getOptionStrict(String value) {
        Option opt = this.getOption(value);

        if(opt == null) {
            throw new SObjPicklistException(value + ' is not a valid value for '+ field);
        }

        return opt;
    }
    
    public Option getOption(String value) {        
        return value2Option.get(value);
    }

    public List<SObjPicklist.Option> getAllOptions() {
        List<SObjPicklist.Option> options = new List<SObjPicklist.Option>();

        for(String value : this.orderedValues) {
            options.add(this.value2Option.get(value));
        }

        return options;
    }

    public List<SObjPicklist.Option> getActiveOptions() {
        List<SObjPicklist.Option> options = new List<SObjPicklist.Option>();

        for(String value : this.orderedValues) {
            Option opt = this.value2Option.get(value);

            if(opt.isActive) {
                options.add(opt);
            }
        }

        return options;
    }

    public class Option {
        @AuraEnabled public String value { public get; private set; }
        @AuraEnabled public String label { public get; private set; }
        @AuraEnabled public Boolean isDefault { public get; private set; }
        @AuraEnabled public Boolean isActive { public get; private set; }

        public Option(PicklistEntry entry) {
            this.value = entry.getValue();
            this.label = entry.getLabel();
            this.isDefault = entry.isDefaultValue();
            this.isActive = entry.isActive();
        }
    }

    public class SObjPicklistException extends Exception { }
}