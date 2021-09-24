import { useCallback, useState } from 'preact/hooks';
import { classNames } from '../utils/style';

type Props = {
    onChange?(e: any): void;
    onInput?(e: any): void;
    onSubmit(e: any): Promise<void>;
};

const initialState = {
    saveDisabled: true,
    data: { text: '' },
};

const CommentForm = ({ onChange, onInput, onSubmit }: Props) => {
    const [state, setState] = useState(initialState);

    const inputHandler = useCallback(
        (e: any) => {
            if (e.target) {
                const { value } = e.target as HTMLInputElement;
                setState({
                    ...state,
                    saveDisabled: false,
                    data: { text: value },
                });
            }
        },
        [state],
    );

    const keyPressHandler = useCallback(
        (e: KeyboardEvent) => {
            if (e.key === 'Enter' && (e.metaKey || e.ctrlKey)) {
                onSubmit(state.data).then(() => setState(initialState));
            }
        },
        [state],
    );
    const submitHandler = useCallback(
        (e: any) => {
            e.preventDefault();
            onSubmit(state.data).then(() => setState(initialState));
        },
        [state],
    );

    return (
        <div className="ct-text-sm ct-text-gray-500 ct-space-x-4">
            <form onSubmit={submitHandler} onInput={inputHandler} onKeyDown={keyPressHandler}>
                <div>
                    <label htmlFor="text" className="ct-sr-only">
                        Comment
                    </label>
                    <div className="ct-mt-1 sm:ct-mt-0 sm:ct-col-span-2">
                        <textarea
                            id="text"
                            name="text"
                            rows={3}
                            value={state.data.text}
                            className="ct-shadow-sm ct-block ct-w-full focus:ct-ring-indigo-500 focus:ct-border-indigo-500 sm:ct-text-sm border ct-border-gray-300 ct-rounded-md"
                            placeholder="Write a comment..."
                        />
                    </div>
                </div>
                <div className="ct-pt-5">
                    <div className="ct-flex ct-justify-end">
                        <button
                            type="button"
                            className="ct-bg-white ct-py-2 ct-px-4 ct-border ct-border-gray-300 ct-rounded-md ct-shadow-sm ct-text-sm ct-font-medium ct-text-gray-700 hover:ct-bg-gray-50 focus:ct-outline-none focus:ct-ring-2 focus:ct-ring-offset-2 focus:ct-ring-indigo-500"
                            onClick={useCallback(() => {
                                setState(initialState);
                            }, [])}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            disabled={state.saveDisabled}
                            className={classNames(
                                state.saveDisabled || state.data.text === ''
                                    ? 'ct-cursor-not-allowed ct-bg-indigo-400'
                                    : 'ct-bg-indigo-600 hover:ct-bg-indigo-700 focus:ct-outline-none focus:ct-ring-2 focus:ct-ring-offset-2 focus:ct-ring-indigo-500',
                                'ct-ml-3 ct-inline-flex ct-justify-center ct-py-2 ct-px-4 ct-border ct-border-transparent ct-shadow-sm ct-text-sm ct-font-medium ct-rounded-md ct-text-white ',
                            )}
                        >
                            Save
                        </button>
                    </div>
                </div>
            </form>
        </div>
    );
};

export default CommentForm;
