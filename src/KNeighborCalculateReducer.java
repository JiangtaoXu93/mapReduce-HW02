import java.io.IOException;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;


/**
 *KNeighborCalculateReducer calculate the mean score of neighborhood score
 *@author jiangtao
 *
 */
public class KNeighborCalculateReducer extends Reducer<Text, IntWritable, Text, DoubleWritable> {
	@Override
	public void reduce(Text key, Iterable<IntWritable> values, Context context) 
			throws IOException, InterruptedException {
		int frequency = 0; 
		int count = 0;
		for (IntWritable value : values) {
			frequency = frequency + value.get();
			count ++;
		}
		context.write(key, new DoubleWritable(((double)frequency) / count)); 
	}
}
