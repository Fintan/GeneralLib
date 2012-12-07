
import utest.Runner;
import tests.TestEvents;
import utest.ui.Report;

class GeneralLibTests {
	
	var runner:Runner;
	
	function new() {
		
		runner = new Runner();
		runner.addCase(new TestEvents());
		
		Report.create(runner);
		runner.run();
		
	}
	
	static function main() {
		new GeneralLibTests();
	}
	
}